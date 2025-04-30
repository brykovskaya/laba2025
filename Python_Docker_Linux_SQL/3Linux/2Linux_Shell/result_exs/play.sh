#!/bin/bash
echo "Введите число: "
read n
if (( $n % 2 == 0 ))
then
  echo "Число $n четное"
else
  echo "Число $n нечетное"
fi