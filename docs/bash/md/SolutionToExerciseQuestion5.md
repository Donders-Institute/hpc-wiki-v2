## Solution to Task 5 Question 5
```bash
for file in *log; do
	var=$(grep "run-time" $file | grep -o " [0-9]\." | grep -o "[0-9]")
	if [[ $var -lt 9 && $var -gt 0 ]]; then 
		echo "$file : $var"
	fi	
done
```
