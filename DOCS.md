# Welcome to documentation
**here you can learn RO-Sharp**

---

1. For Printing an message or a variable write:
```rop
scrie "Hello, World" ## Here is the print command
seteaza x la 10 ## Set the variable
scrie x ## Printing the variable
```

2. Variable:
```rop
seteaza x la 10
## seteaza (set), x (the variable), la 10 (= 10)
```

3. If, Else, Elseif:

```rop
daca x < 10 atunci ## (if x < 10 then), like lua
  scrie "X is less than 10"
stop ## We stop the script

daca x < 10 atunci ## (if x < 10 then), like lua
  scrie "X is less than 10"
altfeldaca x > 100 ## ElseIf
  scrie "x is massive"
altfel ## Else
  scrie "X is bigger than 10"
stop
```



