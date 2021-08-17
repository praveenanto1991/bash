import requests

api1 = 'https://artifactory.xxx.xxx/artifactory/api/storage/folder/'
api2 = 'https://artifactory.xxx.xxx/artifactory/api/copy/folder/'
static = '?to=folder/folder/'

path=[str(path) for path in input("Enter paths semicolon separated,ex praveen-saas/appworks/openldap/1.3.0:").split(';')]
print(path)

def checkrepo():
    for i in range(len(path)):
        response=requests.get(api1+path[i], auth=('user', 'passwd'))
        if(response.status_code == 200):
            print(path[i], "Image exist")
            return copyartifacts()
        else:
            print(path[i], response.reason)
def copyartifacts():
    for i in range(len(path)):
        op=api2+path[i]+static+path[i]
        r=requests.post(api2+path[i]+static+path[i], auth=('user', 'passwd'))
        print(op)
        print(path[i], r.content)
checkrepo()
