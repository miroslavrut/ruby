*Notes

functions are stored in the callstack because the methods haven't finished running so they haven't returned
Which is why with recursion in ruby you can get a stack overflow error. Ruby isn't optimised for recursion so if you keep adding to the callstack it can get full
Where no more memory can be allocated to the stack
If you call that method with a really large number you'd probably hit it
But yeah, you're understanding is correct
That's all recursion really is
Some languages can optimise recursion so it could theoretically run forever, but that's only in method in which the last line is a call to the recursive method and no longer needs to be processed
It can then drop that method from the callstack



