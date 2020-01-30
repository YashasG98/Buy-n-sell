# Buy n' Sell for NITK

### Installation steps

A working installation of Ruby and Rails is assumed.

```bash
git clone https://github.com/YashasG98/IRIS-17CO154-Ruby-on-Rails.git
cd IRIS-17CO154-Ruby-on-Rails/
bundle install
```

### How to run the project

Change the password (replace 'Game_server') at line 17 of config/database.yml to your local MySQL password. Run the following command inside the home folder and open http://localhost:3000/.

```bash
rails db:migrate
rails server
```

### List of all implemented features

* User signup, login, logout
* User can add products to sell
* Shop from where user can buy objects
* User can check products sold by him
* User can check products bought by him
* Appropriate error and success alerts have been added everywhere

### List of non-implemented/planned features

* User profile page
* Admin wallet control

### References used

* progate.com
* Stack overflow