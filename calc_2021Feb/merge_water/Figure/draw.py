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
east  = int(argv[2])
south = int(argv[3])
north = int(argv[4])
cname = argv[5]
outdir = argv[6]

xlint=1.0
ylint=1.0

nx=6000
ny=6000
dx=1./1200.
dy=1./1200.

print 'dx %f' %(dx)
lx=np.arange(west,east,dx)
ly=np.arange(south,north,dy)

print 'west %i : east %i :   south %i : north %i' %(west, east, south, north)

ssize=int(15)
#fig=plt.figure(figsize=(40,40),dpi=100)
fig=plt.figure(figsize=(ssize*1.15,ssize),dpi=100)
fig.subplots_adjust(left=0.05,right=0.95,top=0.95,bottom=0.05)

ax = fig.add_subplot(1,1,1)

#####
rfile="./var_"+cname+".bin"
a=np.fromfile(rfile,float32).reshape(6000,6000)

ocean='#000066'
ll="#ffffff"    ##  dry in both
lw="#ff0000"    ##  wet only in OSM
wl="#00ff00"    ##  wet only in G3WBM 
ww="#0000ff"    ##  wrt in both


bounds=(array([    0,  0.5, 1.5,  10.5, 11.5   ])).tolist()
clist=[             ll,   lw,   wl,   ww, ocean]
cm=colors.ListedColormap(clist)
cm.set_under(ll)

im=plt.imshow(a,cmap=cm,norm=BoundaryNorm(bounds),interpolation='nearest',extent=(west,east,south,north))
###

#divider = make_axes_locatable(ax)
#cax = divider.append_axes("right", size="2%", pad=0.15)

savefig("./fig/"+cname+".jpg")

quit()
