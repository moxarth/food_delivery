import random

menu = [
    {
        "menu_name": "Vegan Mushroom Stroganoff",
        "menu_image": "https://c.ndtvimg.com/2020-09/if4pp5j8_vegetarian_625x300_30_September_20.jpg",
        "restaurant": "Domino's",
        "price": 450
    },
    {
        "menu_name": "Vegan Ramen",
        "menu_image": "https://media.easemytrip.com/media/Blog/India/636977607425696252/636977607425696252QYiiUU.jpg",
        "restaurant": "Domino's",
        "price": 550
    },
    {
        "menu_name": "Vegan Lasagna",
        "menu_image": "https://media-cdn.tripadvisor.com/media/photo-s/0f/c1/6d/c9/the-swad-pure-veg-restaurant.jpg",
        "restaurant": "Domino's",
        "price": 440
    },
    {
        "menu_name": "Vegan Pad Thai",
        "menu_image": "https://media.istockphoto.com/id/638000936/photo/vegan-and-vegetarian-indian-cuisine-hot-spicy-dishes.jpg?s=612x612&w=0&k=20&c=ISxBGeKALq9c11v05BbNw2XtRzQaGn4BddU8BHF9ANk=",
        "price": 350,
        "restaurant": "Domino's",
    },
    {
        "menu_name": "Vegan Chickpea Curry",
        "menu_image": "https://www.gigadocs.com/blog/wp-content/uploads/2020/03/istock-955998758.jpg",
        "restaurant": "Domino's",
        "price": 150
    },
    {
        "menu_name": "Vegan Shepherd's Pie",
        "restaurant": "Domino's",
        "menu_image": "https://www.munnar.holiday/munnartourism/wp-content/uploads/2018/10/popular-vegetarian-food-in-munnar-kerala-800x385.jpg",
        "price": 250
    },
    {
        "menu_name": "Vegan Tacos",
        "restaurant": "Domino's",
        "menu_image": "https://thumbs.dreamstime.com/b/western-food-style-photography-close-up-western-food-style-photography-selective-focus-163948692.jpg",
        "price": 470
    },
    {
        "menu_name": "Vegan Caesar Salad",
        "restaurant": "Domino's",
        "menu_image": "https://www.shutterstock.com/image-photo/burger-onion-rings-cheese-jack-260nw-1455167915.jpg",
        "price": 230
    },
    {
        "menu_name": "Vegan Gnocchi",
        "restaurant": "Domino's",
        "menu_image": "https://cdn.pixabay.com/photo/2018/09/11/16/16/food-3669928__480.jpg",
        "price": 150
    },
    {
        "menu_name": "Vegan Buddha Bowl",
        "restaurant": "Domino's",
        "menu_image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLA7HA6MsNUUL8cY4d_EshtZqcIYDmcEBxCocsu1zH9uOw8UuCUD3pC2qz-pb8gaM8L7w&usqp=CAU",
        "price": 420
    },
    {
        "menu_name": "Vegan Pho",
        "restaurant": "Domino's",
        "menu_image": "https://img.freepik.com/free-photo/fried-onion-rings-table_140725-6647.jpg",
        "price": 320
    },
    {
        "menu_name": "Vegan Meatballs",
        "restaurant": "Domino's",
        "menu_image": "https://apicms.thestar.com.my/uploads/images/2019/11/05/366690.jpg",
        "price": 120
    },
    {
        "menu_name": "Vegan Biryani",
        "restaurant": "Domino's",
        "menu_image": "https://www.theblondtravels.com/wp-content/uploads/2017/10/DSC_1592.jpg",
        "price": 110
    },
    {
        "menu_name": "Vegan Curry",
        "restaurant": "Domino's",
        "menu_image": "https://eatbook.sg/wp-content/uploads/2020/01/Tip-Top-Western-Food-Cicken-Cutlet.jpg",
        "price": 420
    },
    {
        "menu_name": "Vegan Stuffed Peppers",
        "restaurant": "Domino's",
        "menu_image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0n4QFL_LLBTrN7FYJwrp9mkIMQy38ts9QNw&usqp=CAU",
        "price": 320
    },
    {
        "menu_name": "Vegan Lentil Soup",
        "restaurant": "Domino's",
        "menu_image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKAFvLId4Yhq77tTS7ppu3A4il1D-wJnCMtQ&usqp=CAU",
        "price": 120
    },
    {
        "menu_name": "Vegan Mushroom Risotto",
        "restaurant": "Domino's",
        "menu_image": "https://media.istockphoto.com/id/1197374169/photo/fast-food-burger.jpg?b=1&s=170667a&w=0&k=20&c=x33duo9aIDob34YVZ5LG5gbBdjFGtBFK34jj3_0YQj8=",
        "price": 460
    },
    {
        "menu_name": "Vegan Chili",
        "restaurant": "Domino's",
        "menu_image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmcNSfc8gQlEZRJtUCGtA-u4e__TqlvXEtTA&usqp=CAU",
        "price": 120
    },
    {
        "menu_name": "Vegan Tikka Masala",
        "restaurant": "Domino's",
        "menu_image": "https://eatbook.sg/wp-content/uploads/2021/10/no.1-western-food-flat-lay.jpg",
        "price": 430
    },
    {
        "menu_name": "Vegan Falafel",
        "restaurant": "Domino's",
        "menu_image": "https://img.freepik.com/free-photo/side-view-fried-meat-with-french-fries-ketchup_141793-4908.jpg",
        "price": 420
    }
]


# define list of restaurant names and image URLs
restaurant_names = [
  "Burger King",
  "McDonald's",
  "Pizza Hut",
  "Subway",
  "Domino's",
  "KFC",
  "Starbucks",
  "Taco Bell",
  "Tim Hortons",
  "Wendy's",
  "Chipotle",
  "Dunkin'",
  "Panera Bread",
  "Papa John's",
  "Chick-fil-A",
  "Jollibee",
  "Bojangles",
  "Popeyes",
  "In-N-Out Burger",
  "Five Guys"
]

restaurant_image_urls = [
  "https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_103367090-e1571110045215.jpg?auto=format&q=60&fit=max&w=930",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSal6xiZ1X0Wg-RQ-mYh_YE1YACCw853RE0EblmY3Hq2Az9DRE1aFrwx_L5d6xbkMiAshc&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-Qp-NuUXtWVG9AIrMoDuR25fLb1oQEOz7yzhGTcLxqPTfGp_x9LpgYT-NLxwZuxT1Eug&usqp=CAU",
  "https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/10/attachment_74455091-e1571114936278.png?auto=format&q=60&fit=max&w=930",
  "https://i.pinimg.com/originals/c2/18/28/c2182827728e30c28a4c9d49195e1ada.png",
  "https://content.jdmagicbox.com/comp/surat/w5/0261px261.x261.171001090442.s3w5/catalogue/kitchens-badshah-dumas-road-surat-restaurants-7a3bx7i9gg.jpg",
  "https://b.zmtcdn.com/data/pictures/2/18741982/9ce59473d5f5f4c06613d9d22eac9cba.jpg?fit=around|750:500&crop=750:500;*,*",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwCMbtUmHxTGSm09YgbNUpCd69ijThoQ6qrg&usqp=CAU",
  "https://i.pinimg.com/originals/f2/48/a0/f248a0cbe29620456f016d7912035b33.png",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9RGrV2zqjg5hr6fIa3mDmPy_1O9fPqAMJzBKA8osMQfi2zlOPNbEUo6aMNjzjQ82gkf4&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLTcCMB55IJd-fIep6lM9luiKUYPxvzthJadk7TXqY7XcGUQmVQDFvEvik51GflBF8AmE&usqp=CAU"
]

# define list of ratings
ratings = [4.2, 4.5, 4.1, 4.7, 4.0, 4.4, 4.8, 4.3, 4.6, 4.9]

# create the list of dictionaries
restaurants = []
for i in range(20):
  name = random.choice(restaurant_names)
  image_url = random.choice(restaurant_image_urls)
  rating = random.choice(ratings)
  restaurant = {"name": name, "image_url": image_url, "rating": rating}
  restaurants.append(restaurant)

# print the list of dictionaries
def get_random_rests():
    return restaurants
