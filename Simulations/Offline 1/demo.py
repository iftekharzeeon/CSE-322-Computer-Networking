file1 = open("trace.tr", "r")

Lines = file1.readlines()

count = 1
for line in Lines:
    count += 1


print(count)