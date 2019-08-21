alias Ebaze.Accounts.User
alias Ebaze.Auctions.Auction
alias Ebaze.Repo

Repo.insert! %User{
    username: "username",
    password: "password"
}

Repo.insert! %User{
    username: "username",
    password: "test"
}

Repo.insert! %Auction{
    name: "Canon T5i camera",
    description: "Canon DSLR camera with 18-55mm kit lens - sold as is",
    photo_url: "https://unsplash.com/photos/g4wujH0p80o",
    initial_price: 250.0,
    sold: false
}

