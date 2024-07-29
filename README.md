# Top up app

A flutter app where user can top-up to their beneficiary.

## Features

User can:

- add new beneficiaries upto 5 person.
- top up each beneficiaries which has a max limit for a month.
- see real-time balance updates.

#### Clone the app

```script
git@github.com:sagarkarki99/top-up-app.git
```

#### Go to project

```script
cd top_up_app
```

#### Run the command

```script
flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
```

##### Additional note

In-order to update the transaction limit, `isVerified` flag in `User` instance should be updated to `true`/`false`, manually for verified/unverified user inside `MockDataStore` class and re-run the app.
By default it is verified user.
