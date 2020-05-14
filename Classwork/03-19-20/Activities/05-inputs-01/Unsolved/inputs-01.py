
welcome_name = input("Welcome to the sandwich shop. What do I call you?")

print(f"Hello {welcome_name}")

question_sandwich = input("Are you here for a sandwich? Yes or No.")

if question_sandwich == "Yes":
    food_prompt = input("What kind of sandwich would you like?")
    print("Please wait 10 minutes for your {food_prompt}")
elif question_sandwich == "No":
    print("If you don't want a sandwich, then why are you here?")
else:
    print("You did not write Yes or No!")


