// ./src/api/product/content-types/product/lifecycles.ts

export default {
  async beforeCreate(event) {
    const { data } = event.params;
    if (!data.ending_date) {
      const newDate = new Date();
      newDate.setDate(newDate.getDate() + 10);
      data.ending_date = newDate.toISOString();
    }
  }
};
