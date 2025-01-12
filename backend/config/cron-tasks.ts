// config/cron-tasks.ts

export default {
  lotteryCheck: {
    task: async ({ strapi }) => {
      console.log('[CRON] Lottery kontrolü başladı (Document Service API).');

      try {
        const now = new Date();

        // 1) lottery_product = true, manual_lottery=false/null, ending_date < now, lottery_winner null
        //   Document Service API'de filters parametresi “v4” ile benzer şekilde kullanılıyor.
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
            // populate alanları
            populate: {
              lottery_users: {
                populate: 'biduser',
              },
            },
            // draft & publish kontekstinde default `status: 'draft'` döner,
            // eğer "published" sürümlerini sorgulamak isterseniz `status: 'published'` ekleyebilirsiniz.
            // Ama bitmiş lottery genelde "draft" modundaki en güncel sürümü yakalamak için yeterli.
          });

        if (!endedLotteryProducts || endedLotteryProducts.length === 0) {
          console.log('[CRON] Bitmiş ürün yok veya winner zaten atanmış (Document Service).');
          return;
        }

        console.log(`[CRON] ${endedLotteryProducts.length} üründe çekiliş yapılacak (DocService).`);

        for (const product of endedLotteryProducts) {
          if (!product.lottery_users?.length) {
            console.log(`[CRON] Ürün "${product.title}" için lottery_users boş.`);
            continue;
          }

          // Rastgele index
          const randomIndex = Math.floor(Math.random() * product.lottery_users.length);
          const chosenLotteryUser = product.lottery_users[randomIndex];

          if (!chosenLotteryUser?.biduser?.documentId) {
            console.log(`[CRON] Ürün "${product.title}", seçilen user'ın documentId yok!`);
            continue;
          }

          const winnerDocId = chosenLotteryUser.biduser.documentId;
          console.log(`[CRON] Ürün "${product.title}" kazanan: ${winnerDocId}`);

          // 2) "lottery_winner" set etme
          // Document Service API'de update => "strapi.documents(uid).update({ documentId, data, status })"
          // - "documentId" => product.documentId (ana belgenin)
          // - "data" => Değiştirilecek alanlar
          // - "status: 'published'" => eğer otomatik publish etmek isterseniz
          await strapi.documents('api::product.product').update({
            documentId: product.documentId, // Burada numeric ID yerine documentId
            data: {
              lottery_winner: winnerDocId,
            },
            // "status: 'published'" => ekleyerek direkt published hale getirebilirsiniz.
            status: 'published', // (Opsiyonel)
          });

          console.log(`[CRON] Ürün "${product.title}" güncellendi (DocService).`);
        }

        console.log('[CRON] Lottery kontrolü tamam (DocService).');
      } catch (err) {
        console.error('[CRON] Lottery kontrolünde hata (DocService):', err);
      }
    },
    options: {
      rule: '*/30 * * * *', // 30 dakikada bir
      tz: 'Europe/Stockholm', // isterseniz
    },
  },
};
