import random

menu = [
    {
        "menu_name": "Vegan Mushroom Stroganoff",
        "menu_image": "https://www.eatingbirdfood.com/wp-content/uploads/2018/03/veganglutenfreemushroomstroganoff-8.jpg",
        "price": 450
    },
    {
        "menu_name": "Vegan Ramen",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2020/09/vegan-ramen-recipe-6.jpg",
        "price": 550
    },
    {
        "menu_name": "Vegan Lasagna",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2019/06/vegan-lasagna-recipe-3.jpg",
        "price": 440
    },
    {
        "menu_name": "Vegan Pad Thai",
        "menu_image": "https://minimalistbaker.com/wp-content/uploads/2019/05/15-Minute-Vegan-Pad-Thai-SQUARE.jpg",
        "price": 350
    },
    {
        "menu_name": "Vegan Chickpea Curry",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2018/11/vegan-chickpea-curry-recipe-8.jpg",
        "price": 150
    },
    {
        "menu_name": "Vegan Shepherd's Pie",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2019/02/vegan-shepherds-pie-recipe-5.jpg",
        "price": 250
    },
    {
        "menu_name": "Vegan Tacos",
        "menu_image": "https://minimalistbaker.com/wp-content/uploads/2020/09/vegan-jackfruit-tacos-5-minutes-.jpg",
        "price": 470
    },
    {
        "menu_name": "Vegan Caesar Salad",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2019/09/vegan-caesar-salad-recipe-3.jpg",
        "price": 230
    },
    {
        "menu_name": "Vegan Gnocchi",
        "menu_image": "https://i1.wp.com/www.eatthis.com/wp-content/uploads/media/images/ext/415981287/vegan-gnocchi.jpg",
        "price": 150
    },
    {
        "menu_name": "Vegan Buddha Bowl",
        "menu_image": "https://cookieandkate.com/images/2019/02/vegetarian-buddha-bowl-recipe-2.jpg",
        "price": 420
    },
    {
        "menu_name": "Vegan Pho",
        "menu_image": "https://i0.wp.com/livingcambrook.com.au/wp-content/uploads/2021/04/vegan-pho.jpg",
        "price": 320
    },
    {
        "menu_name": "Vegan Meatballs",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2021/02/vegan-meatballs-recipe-1.jpg",
        "price": 120
    },
    {
        "menu_name": "Vegan Biryani",
        "menu_image": "https://i.pinimg.com/originals/e2/2b/70/e22b7019e9c8b1cb531797a0dcc2a7f6.jpg",
        "price": 110
    },
    {
        "menu_name": "Vegan Curry",
        "menu_image": "https://i2.wp.com/cdn-prod.medicalnewstoday.com/content/images/articles/317/317616/vegan-curry-bowl.jpg?w=1155&h=1541",
        "price": 420
    },
    {
        "menu_name": "Vegan Stuffed Peppers",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2020/02/vegan-stuffed-peppers-recipe-1.jpg",
        "price": 320
    },
    {
        "menu_name": "Vegan Lentil Soup",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2020/02/vegan-lentil-soup-recipe-1.jpg",
        "price": 120
    },
    {
        "menu_name": "Vegan Mushroom Risotto",
        "menu_image": "https://itdoesnttastelikechicken.com/wp-content/uploads/2019/10/Vegan-Mushroom-Risotto-18.jpg",
        "price": 460
    },
    {
        "menu_name": "Vegan Chili",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2020/01/vegan-chili-recipe-1.jpg",
        "price": 120
    },
    {
        "menu_name": "Vegan Tikka Masala",
        "menu_image": "https://i0.wp.com/www.eatthis.com/wp-content/uploads/media/images/ext/353167985/vegan-tikka-masala.jpg",
        "price": 430
    },
    {
        "menu_name": "Vegan Falafel",
        "menu_image": "https://www.noracooks.com/wp-content/uploads/2020/08/vegan-falafel-recipe-1.jpg",
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
  restaurant = {"name": name, "image": image_url, "rating": rating}
  restaurants.append(restaurant)

# print the list of dictionaries
def get_random_rests():
    return restaurants
