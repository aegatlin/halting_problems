jan = range(1, 32)
feb = range(1, 29)
leap_feb = range(1, 30)
mar = range(1, 32)
apr = range(1, 31)
may = range(1, 32)
jun = range(1, 31)
jul = range(1, 32)
aug = range(1, 32)
sep = range(1, 31)
oct = range(1, 32)
nov = range(1, 31)
dec = range(1, 32)

year = [*jan, *feb, *mar, *apr, *may, *jun, *jul, *aug, *sep, *oct, *nov, *dec]
leap_year = [
    *jan,
    *leap_feb,
    *mar,
    *apr,
    *may,
    *jun,
    *jul,
    *aug,
    *sep,
    *oct,
    *nov,
    *dec,
]

century = []
for i in range(1901, 2001):
    if i % 4 == 0:
        century.extend(leap_year)
    else:
        century.extend(year)

# Jan 1st, 1901 was a Tuesday. century[0]
# Jan 6th, 1901 was a Sunday. century[5]
sundays_on_first_of_month = 0
i = 0
while i <= len(century):
    # If it's a Sunday...
    if (i % 7) - 5 == 0:
        # And it's the first of the month...
        if century[i] == 1:
            sundays_on_first_of_month += 1

    i += 1

# print(sundays_on_first_of_month)
