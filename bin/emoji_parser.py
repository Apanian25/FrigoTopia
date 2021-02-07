import glob
result = glob.glob("/home/nguyenquannnn/Projects/FrigoTopia/client/app/assets/images/food/*.png")

print([{'name': i.split('/')[-1].split('-')[1], 'path': i[i.index('assets/'):]} for i in result])
# os.dir(pathlib.Path("/home/nguyenquannnn/Projects/FrigoTopia/client/app/assets/images/food").resolve()