import os
import sys
from subprocess import check_call, run


def helm_versions():
    '''
    Returns the Helm versions that should be built.
    '''
    return ['v2.12.3']


def kubectl_versions():
    '''
    Returns the kubectl versions that should be built.
    '''
    return ['v1.12.4']


def terraform_versions():
    '''
    Returns the terraform versions that should be build.
    '''
    return ['0.11.11']


class Version:
    def __init__(self, helm='', kubectl='', terraform=''):
        self.helm = helm
        self.kubectl = kubectl
        self.terraform = terraform

    def tag(self):
        if self.terraform:
            # all values present
            return f'{self.helm}__{self.kubectl}__{self.terraform}'.replace('v', '')
        else:
            if self.kubectl:
                return f'{self.helm}__{self.kubectl}'.replace('v', '')
            else:
                if self.helm:
                    return self.helm.replace('v', '')
                else:
                    return 'latest'


def versions():
    for h in helm_versions():
        for k in kubectl_versions():
            for t in terraform_versions():
                yield Version(helm=h, kubectl=k, terraform=t)


def aliases(version):
    if version.terraform == terraform_versions()[-1]:
        yield Version(helm=version.helm, kubectl=version.kubectl)
        if version.kubectl == kubectl_versions()[-1]:
            yield Version(helm=version.helm)
            if version.helm == helm_versions()[-1]:
                yield Version()


def images():
    with os.scandir('.') as it:
        for entry in it:
            if not entry.name.startswith('.') and entry.is_dir():
                yield entry.name


def build_one(folder, version):
    print(f'Building {folder} with version {version.tag()}')

    check_call([
        'docker', 'build',
        '-t', f'ngeor/{folder}:{version.tag()}',
        '--build-arg', f'HELM_VERSION={version.helm}',
        '--build-arg', f'KUBECTL_VERSION={version.kubectl}',
        '--build-arg', f'TERRAFORM_VERSION={version.terraform}',
        '.'
    ], cwd=folder)


def tag(image, version, alias):
    print(f'Tagging {version.tag()} as {alias.tag()}')
    check_call([
        'docker', 'tag', f'ngeor/{image}:{version.tag()}', f'ngeor/{image}:{alias.tag()}'
    ])


def build():
    print('Building')
    for image in images():
        for version in versions():
            build_one(image, version)
            for alias in aliases(version):
                tag(image, version, alias)


def login():
    username = os.environ['DOCKER_USERNAME']
    password = os.environ['DOCKER_PASSWORD']
    run(['docker', 'login', '-u', username,
         '--password-stdin'], input=password, encoding='ascii', check=True)


def logout():
    check_call(['docker', 'logout'])


def push(folder, version):
    print(f'Pushing {folder} {version.tag()}')
    check_call(['docker', 'push', f'ngeor/{folder}:{version.tag()}'])


def deploy():
    print('Deploying')
    login()

    for image in images():
        for version in versions():
            push(image, version)
            for alias in aliases(version):
                push(image, alias)

    logout()


if __name__ == "__main__":
    build()
    if '--deploy' in sys.argv:
        deploy()
