
subject = None
subject = "Programmers"
first_name = ""
first_name = "Ada"
last_name = "Lovelace"
full_name = f"{first_name} {last_name}"
profession = "Computer Programmer"
known_for = "First Computer Programmer"
first_algorithm = "Analytical Engine"
city_location = "London"
country_location = "England"
nationality = "British"
birth_year = 1815
death_year = 1852
age_of_passing = death_year - birth_year
year_of_publish = 1842
print(f"First Name: {first_name}")
print(f"Last Name: {last_name}")
print(f"Profession: {profession}")
print(f"Birth Year: {birth_year}")

statement_one = f"{subject}: {first_name} {last_name} is a {nationality} born in {birth_year}."
print(statement_one)


statement_two = f"She is commonly referred to as the {known_for}."
print(statement_two)


statement_three = f"In 1842 she published the first Algorithm, {first_algorithm}, at the age of 27."
print(statement_three)


statement_four = f"She was a {nationality} Citizen who lived in {city_location}, {country_location} until her passing in {death_year} at the age {age_of_passing}."
print(statement_four)


