#!/bin/sh

curl "https://api.hh.ru/vacancies?text=data+scientist&found=20" | jq "." > "hh.json"