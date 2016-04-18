import gdb

# The catch break point must be in the gdb variable `$cbp`
class BExpEx (gdb.Breakpoint):
    '''Start of break in expected exception'''
    def __init__(self, spec=None):
        super().__init__(spec)

    def stop(self):
        gdb.parse_and_eval('$sb = 0')
        return False
