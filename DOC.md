# Project Documentation

## Add & Manage Products

There are two types of products: Offer and Lottery. Lottery products are also divided into two groups, manual and automatic, depending on the type of draw.

**Bidding Products:** These products are a classic auction product structure where users participate by raising the price. At the end of the specified ending date, the user who makes the highest bid wins the product.

**Lottery Products:** Users register themselves for a lottery product. At the end of the specified ending date, the lottery product operates automatically or manually and selects one of the participants as the winner.

It is possible to create and manage both products in a single product interface in the backend.

### Create a new product

- Log in to the Strapi admin dashboard (http://localhost:1337/admin)
- Click on "Content Manager" in the left menu.
- Under "Collection Types" find and click "Product".
- Click "Create new entry" button for create a new product.
- Fill in the fields explained below.
- Click "Publish" or "Save" button to save or publish the product. *"Save" saves the product as a draft, product is not displayed on the frontpage*

#### Product fields & explains:

- `title`* : Product name
- `description` : Product information and description area. *Html is not allowed.*
- `categories` : Select a category for the product. Multiple categories can be selected.
- `price` : Minimum price. If there is a price on the product, it determines the starting price for auction items, and for lottery items, it determines the price the user will pay even if they win the item. *It can be left blank.*
- `main_picture` : Featured image of the product. *If left blank the system will display a placeholder.png product image instead.*
- `gallery` : If have other pictures of the product can be add here. *It can be left blank.*
- `ending_date` : Determine the product expired date. **When the item expires:**

    - **if it is an auction product:** it will stop accepting new bids and show the highest bid as the winner.

    - **if it is a lottery product:** It is removed from the frontend and does not accept new registrations. When the Cron Job is ready to run, a winner is randomly and automatically selected for this product. The winning user is also saved on the database and shows in the lottery_winner field within this product.



`*` Mandatory fields

# Customizable areas
Detailed information about customizable areas in the project. Below you can find the descriptions and related files for each one.

## Automatic ending_date assignment

When a new product is saved, if the product ending_date field is empty, the system automatically assigns `10 days` later as the ending_date.

[/backend/src/api/product/content-types/product/lifecycles.ts](https://github.com/ozayo/auktion/blob/main/backend/src/api/product/content-types/product/lifecycles.ts)

```
async beforeCreate(event: any) {
    const { data } = event.params;
    if (!data.ending_date) {
      const newDate = new Date();
      newDate.setDate(newDate.getDate() + 10);
      data.ending_date = newDate.toISOString();
    }
  },
```
Change days `+ 10` to any.

## Lottery limit

Each user can register for the lottery for a maximum of 5 products.

[/frontend/components/LotForm.tsx](https://github.com/ozayo/auktion/blob/main/frontend/components/LotForm.tsx)

change the limit here:

`const LOTTERY_LIMIT = 5;`

## Auto lottery (Cron job)

It finds the relevant products within a specified period of time and determines a random winner among the users and records it in the db.

[/backend/config/cron-tasks.ts](https://github.com/ozayo/auktion/blob/main/backend/config/cron-tasks.ts)

```
options: {
      rule: '0 6 * * 1-5', // run at 6:00 AM, Monday through Friday
      tz: 'Europe/Stockholm',
    },
```
change to `rule` for new run time

Explanation:

0: Minute field. The value 0 represents the beginning of the hour.
6: Hour field. This represents 6:00 AM.
*: Day of the month field. The asterisk represents every day of the month.
*: Month field. The asterisk represents every month.
1-5: Day of the week field. The range 1-5 represents Monday through Friday.
This expression will cause your cron job to run at 6:00 AM every weekday (Monday to Friday).

Important Notes:

Cron expressions are composed of 5 fields separated by spaces.
Each field represents a specific unit of time (minute, hour, day of the month, month, and day of the week).
An asterisk (*) represents all possible values.
A hyphen (-) can be used to specify a range of values (e.g., 1-5).
A comma (,) can be used to specify multiple values (e.g., 1,3,5).

## Run manuel lottery (With product update)

Created in case the automatic lottery does not work or for special needs.
Usage: Go to any lottery product, set the ending_date to a date older than the current date and "publish" if it is outside the conditions below.

Conditions:
- lottery_product = true
- manual_lottery = false (automatic draw enabled)
- ending_date has passed (before now)
- lottery_winner has not been assigned yet
- lottery_users is not empty (must at least one user)

[/backend/src/api/product/content-types/product/lifecycles.ts](https://github.com/ozayo/auktion/blob/main/backend/src/api/product/content-types/product/lifecycles.ts)

All related code under `async afterUpdate(event: any)`

## Run manuel lottery (On frontend)

... in progress

## ProductList Component Usage

Show specific products on anywhere with conditions.

File: frontend/components/ProductList.tsx

### Here are all the properties of the ProductList component:

#### `productType` (optional, default: 'all')

`'all'`: Retrieves all products.
`'bidding'`: Retrieves only auction products.
`'lottery'`: Retrieves all lottery products (manual and auto).
`'lotteryManual'`: Retrieves only manual lottery products.
`'lotteryAuto'`: Retrieves only automatic lottery products.

#### `showItems` (optional, default: 3)

Determines how many products to display.
Has no minimum or maximum limit.

#### `sorting` (optional, default: true)

`true`: Displays all sorting options.
`false`: Hides sorting options.
`'custom'`: Displays custom sorting options (determined by customSorting).

#### `customSorting` (optional)

`'newfirst'`: Newest products first (createdAt:desc)
`'oldfirst'`: Oldest products first (createdAt:asc)
`'timeshort'`: Products with the closest end time first (ending_date:asc)
`'timelong'`: Products with the furthest end time first (ending_date:desc)
`'highbid'`: Products with the highest bid first (highestBid:desc)
`'lowbid'`: Products with the lowest bid first (highestBid:asc)

#### `showImage` (optional, default: true)

`true`: Displays product images.
`false`: Hides product images.

#### `title` (optional)

Sets the title of the product list.
If not specified, no title is displayed.

#### `showOld` (optional, default: false)

`true`: Also displays expired products.
`false`: Displays only active products.

#### `category` (optional, default: all)

Show products by category to using category slug.

`category="telefon" ``

#### Sample use:

import component first:

```jsx
import CategoryList from "@/components/CategoryList";
```

code samples:

```jsx
      {/* Senaste auktioner */}
      <ProductList
        productType="bidding"
        showItems={3}
        title="Senaste auktioner"
        sorting="custom"
        customSorting={['newfirst', 'timeshort']}
        showOld={false}
      />
      
      {/* Manuella lotterier */}
      <ProductList
        productType="lottery"
        showItems={3}
        title="Alla lotterier"
        sorting={true}
        showOld={false}
      />

      {/* Automatiska lotterier */}
      <ProductList
        productType="lotteryAuto"
        showItems={3}
        title="Automatiska lotterier"
        sorting={false}
        showOld={false}
      />

      {/* Manuella lotterier */}
      <ProductList
        productType="lotteryManual"
        showItems={1}
        title="Manuella lotterier"
        sorting={false}
        showOld={false}
      />

      <ProductList
        productType="bidding"
        showItems={3}
        title="Dator Auktioner"
        sorting="custom"
        customSorting={['newfirst', 'timeshort']}
        showOld={false}
        category="dator"  // slug of category
      />

```

## Strapi Pagination Limit

Strapi rest api items come with 25 items limit by page. It happened some problem on #29 bu we fix it with https://github.com/ozayo/auktion/commit/413f3ab7bacd8b899f406b5907004a67586e9585.

Limit can be change on backend/config/api.ts. now limits are;

```
export default {
  rest: {
    defaultLimit: 100,
    maxLimit: 300,
    withCount: true,
  },
};
```

More info on Strapi Doc; [Sort and Pagination](https://docs.strapi.io/dev-docs/api/rest/sort-pagination#pagination-by-offset) and [API configuration](https://docs.strapi.io/dev-docs/configurations/api)