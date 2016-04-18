python
import sys
sys.path.insert(0, '/home/swd/gdb/unittest')
end

tty /home/swd/gdb/unittest/debug_output.txt
set pagination off
set print static-members off

# for determining if the program has exited
set $_exitcode = -999

# for easily printing collections
set $i=0

#break on runner::fail (unittest failure)
b runner.h:325
set $f=$bpnum
# dis $f


set args --unittest
set exec-wrapper taskset -c 0

set $sb = 1
catch throw
commands $bpnum
if $sb == 0
    set $sb = 1
    continue
end
end

python
import exp_ex_break
to_brk = ['Status.test.cpp:188', 'weak_fn.test.cpp:114', 'LexicalCast.cpp:77',
          'LexicalCast.cpp:174', 'store.h:930',
          'recover.h:96', 'recover.h:147', 'recover.h:148',
          'recover.h:137', 'recover.h:138', 'recover.h:139',
          'AmendmentTable.test.cpp:197', 'AmendmentTable.test.cpp:215',
          'AmendmentTable.test.cpp:233', 'AmendmentTable.test.cpp:252',
          'Handler.h:290',
          'Env_test.cpp:92', 'Env_test.cpp:102',
          'Env.cpp:476',
          'Config.test.cpp:273',
          'STAccount.test.cpp:101',
          'STObject.test.cpp:213', 'STObject.test.cpp:262', 'STObject.test.cpp:285',
          'STObject.test.cpp:286', 'STObject.test.cpp:313', 'STObject.test.cpp:317',
          'STObject.test.cpp:331', 'STObject.test.cpp:345', 'STTx.test.cpp:146',
          'STAmount.cpp:913',
          'STParsedJSON.cpp:236',
          'CheckLibraryVersions.test.cpp:57',
          'Object.test.cpp:169', 'Object.test.cpp:175', 'Object.test.cpp:181',
          'Object.test.cpp:193', 'Object.test.cpp:201', 'Object.test.cpp:209',
          'Object.test.cpp:221',
          'mulDiv.test.cpp:61',
          'STAmount.test.cpp:132', 'STAmount.test.cpp:587', 'STAmount.test.cpp:619',
          ]

for b in to_brk:
    exp_ex_break.BExpEx (b)

def exit_handler(event):
    import gdb
    gdb.execute("quit")

gdb.events.exited.connect(exit_handler)
end

r

# while ($_exitcode != -999)
#    set $_exitcode = -999
#    r
# end

