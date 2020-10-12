import os
import glob

opts = Options('custom.py')
opts.Add('CXXFLAGS', 'The C++ compiler flags.', '-g -O0 -Wall')

env = Environment(SHLIBPREFIX='',
                  ENV = os.environ,
                  options=opts)
Help(opts.GenerateHelpText(env))

env.ParseConfig("pkg-config --cflags --libs clanCore-0.8 clanDisplay-0.8 clanGL-0.8 clanSignals-0.8")

ptest = env.Program('main',
                    ['main.cxx', 'colltest.cxx','collision.cxx'])

# EOF #

