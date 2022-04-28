import os
import glob

# opts = Options('custom.py')
# opts.Add('CXXFLAGS', 'The C++ compiler flags.', '-g -O0 -Wall')

env = Environment(SHLIBPREFIX='',
                  ENV = os.environ)
                  # options=opts)
# Help(opts.GenerateHelpText(env))

env.ParseConfig("pkg-config --cflags --libs clanCore-1.0 clanDisplay-1.0 clanGL-1.0 clanSignals-1.0")

ptest = env.Program('main',
                    ['main.cxx', 'colltest.cxx','collision.cxx'])

# EOF #

