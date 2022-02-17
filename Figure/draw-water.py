import sys
import os

from pylab import *
import numpy as np

import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib import colors
from matplotlib.ticker import FormatStrFormatter
from mpl_toolkits.axes_grid1 import make_axes_locatable

import warnings;warnings.filterwarnings('ignore')

class BoundaryNorm(colors.Normalize):
    def __init__(self, boundaries):
        self.vmin = boundaries[0]
        self.vmax = boundaries[-1]
        self.boundaries = boundaries
        self.N = len(self.boundaries)

    def __call__(self, x, clip=False):
        x = np.asarray(x)
        ret = np.zeros(x.shape, dtype=np.int)
        for i, b in enumerate(self.boundaries):
            ret[np.greater_equal(x, b)] = i
        ret[np.less(x, self.vmin)] = -1
        ret = np.ma.asarray(ret / float(self.N-1))
        return ret

argv  = sys.argv
west  = int(argv[1])
south = int(argv[2])
cname = argv[3]
outdir = argv[4]

east  = west  + 5
north = south + 5

xlint=1.0
ylint=1.0

nx=6000
ny=6000
dx=1./1200.
dy=1./1200.

lx=np.arange(west,east,dx)
ly=np.arange(south,north,dy)

print('west %f : east %f :   south %f : north %f' %(west, east, south, north) )

ssize=int(40)
#fig=plt.figure(figsize=(40,40),dpi=100)
fig=plt.figure(figsize=(ssize,ssize),dpi=100)
fig.subplots_adjust(left=0.05,right=0.95,top=0.95,bottom=0.05)

ax = fig.add_subplot(1,1,1)

###

rfile="./wat_"+cname+".bin"
g1w=np.fromfile(rfile,float32).reshape(ny,nx)
#g1w=np.ma.masked_where(g1w<-999,g1w)

#im=plt.imshow(g1w,cmap=cm.Reds,interpolation='nearest',extent=(west,east,south,north))

## cumtam colormap code
sea='#9999cc' ## -99
lnd='#ffffff' ## 0
oth="#999999"  ## 21 small
can='#ff0000'  # 31 canal
riv='#00aa99'  # 41 river line
pol='#0000aa'  # 51 river poly
##
bounds=(array([-5,    15,    25,   35,    45,    55])).tolist()
clist=[          lnd,  oth,  can,   riv,   pol]
cmwat=colors.ListedColormap(clist)
cmwat.set_under(sea)

im=plt.imshow(g1w,cmap=cmwat,norm=BoundaryNorm(bounds),interpolation='nearest',extent=(west,east,south,north))

plt.tick_params(labelsize=ssize,pad=5,length=5)
plt.xticks( np.arange(west,east+0.000001,xlint) )
plt.yticks( np.arange(south,north+0.000001,ylint) )
#plt.title("Title", fontsize=ssize*2.5, loc='left',pad=20)

#cb=colorbar(boundaries=bounds, fraction=0.12, aspect=45.,shrink=0.88,drawedges=True,ticks=bounds,orientation='horizontal')# ,extend='min')
savefig("./"+outdir+"/"+cname+".png")

quit()


