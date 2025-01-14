// ./src/api/product/content-types/product/lifecycles.ts

export default {
  /**
   * 1) beforeCreate
   *    - If "ending_date" is not specified, it will be 10 days later. */
  async beforeCreate(event: any) {
    const { data } = event.params;
    if (!data.ending_date) {
      const newDate = new Date();
      newDate.setDate(newDate.getDate() + 10);
      data.ending_date = newDate.toISOString();
    }
  },

  /**
  * 2) afterUpdate
  * - Automatically determines "lottery winner"
  * - Conditions:
  * a) lottery_product = true
  * b) manual_lottery = false (automatic draw enabled)
  * c) ending_date has passed (before now)
  * d) lottery_winner has not been assigned yet
  * - Randomly selects the biduser.documentId of one of the "lottery_users" and writes it to the "lottery_winner" field
  */
  async afterUpdate(event: any) {
    const { result } = event; // Updated Product record (any)

    try {
      // 1) lottery_product = true ?
      if (!result.lottery_product) return;

      // 2) If manual_lottery = true, do not make automatic lottery
      if (result.manual_lottery) {
        console.log(`[afterUpdate] manual_lottery=true, otomatik çekiliş iptal. Ürün: ${result.title}`);
        return;
      }

      // 3) ending_date is passed?
      const now = new Date();
      const productEndDate = new Date(result.ending_date || '');
      if (productEndDate > now) {
        // ending date is not passed yet
        return;
      }

      // 4) Is there already a lottery_winner? If so, do not make automatic lottery
      if (result.lottery_winner) {
        return;
      }

      // 5) We pull the product again as "fresh"
      // => In this way, "lottery_users" and "biduser" below it will be populated
      const freshProduct: any = await strapi.entityService.findOne(
        'api::product.product',
        result.id,
        {
          // where: { documentId: result.documentId },
          populate: {
            lottery_users: {
              populate: 'biduser',
            },
          },
        }
      );

      // 6) Is there any "lottery_users"? If not, do not make automatic lottery
      if (!freshProduct?.lottery_users?.length) {
        console.warn('[afterUpdate] lottery_users boş veya undefined.');
        return;
      }

      // 7) Choose a random "lottery_user"
      const randomIndex = Math.floor(Math.random() * freshProduct.lottery_users.length);
      const chosenLotteryUser = freshProduct.lottery_users[randomIndex];

    
      // 8) Does biduser.documentId exist?
      if (!chosenLotteryUser?.biduser?.documentId) {
        console.warn(`[afterUpdate] Selected lottery_user has no biduser or documentId!`);
        return;
      }

      const winnerBidUserDocId = chosenLotteryUser.biduser.documentId;

      // 9) Set "lottery_winner" on the product as the winner
      await strapi.entityService.update('api::product.product', result.id, {
        data: {
          lottery_winner: winnerBidUserDocId,
        },
      });

      console.log(
        `🎉 [afterUpdate] Auto lottery is done! Winner => ${winnerBidUserDocId} (Product: ${freshProduct.title})`
      );

    } catch (err) {
      console.error('Lottery winner assign error:', err);
    }
  },
};
