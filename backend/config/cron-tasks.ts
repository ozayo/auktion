// config/cron-tasks.ts

export default {
  lotteryCheck: {
    task: async ({ strapi }) => {
      console.log('[CRON] Lottery check started (Document Service API).');

      try {
        const now = new Date();

        // 1) Check and find correct products
        // Check lottery_product = true, manual_lottery=false/null, ending_date < now, lottery_winner null
        const endedLotteryProducts = await strapi
          .documents('api::product.product')
          .findMany({
            filters: {
              lottery_product: true,
              $or: [
                { manual_lottery: false },
                { manual_lottery: { $null: true } },
              ],
              ending_date: { $lt: now },
              lottery_winner: { $null: true },
            },
            // populate fields
            populate: {
              lottery_users: {
                populate: 'biduser',
              },
            },
          });

        if (!endedLotteryProducts || endedLotteryProducts.length === 0) {
          console.log('[CRON] There is no finished product or winner has already been assigned (Document Service).');
          return;
        }

        console.log(`[CRON] A lottery will be held on the ${endedLotteryProducts.length} product (DocService).`);

        for (const product of endedLotteryProducts) {
          if (!product.lottery_users?.length) {
            console.log(`[CRON] Lottery_users for product "${product.title}" is empty.`);
            continue;
          }

          // Find a random user from lottery_users
          const randomIndex = Math.floor(Math.random() * product.lottery_users.length);
          const chosenLotteryUser = product.lottery_users[randomIndex];

          if (!chosenLotteryUser?.biduser?.documentId) {
            console.log(`[CRON] Product "${product.title}", selected user has no documentId!`);
            continue;
          }

          const winnerDocId = chosenLotteryUser.biduser.documentId;
          console.log(`[CRON] For product "${product.title}" winner is: ${winnerDocId}`);

          // 2) Set "lottery_winner"
          // In Document Service API update => "strapi.documents(uid).update({ documentId, data, status })"
          // - "documentId" => product.documentId (of the main document)
          // - "data" => Fields to be changed
          // - "status: 'published'" => if you want to publish automatically
          await strapi.documents('api::product.product').update({
            documentId: product.documentId, 
            data: {
              lottery_winner: winnerDocId,
            },
            // "status: 'published'" => if you want to change product status publish automatically after update
            status: 'published', // optional
          });

          console.log(`[CRON] Product "${product.title}" updated (DocService).`);
        }

        console.log('[CRON] Lottery check is done (DocService).');
      } catch (err) {
        console.error('[CRON] ERROR on Lottery check (DocService):', err);
      }
    },
    options: {
      rule: '0 6 * * 1-5', // run at 6:00 AM, Monday through Friday
      tz: 'Europe/Stockholm', // Timezone for Stockholm
    },
  },
};
