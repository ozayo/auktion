export const dateFormatLong = (dateString: string): string => {
  const date = new Date(dateString);
  return date.toLocaleDateString("sv-SE", {
    year: "numeric",
    month: "long",
    day: "numeric",
    hour: "2-digit",
    minute: "2-digit",
  });
};

export const dateFormatWithouth = (dateString: string): string => {
  const date = new Date(dateString);
  return date.toLocaleDateString("sv-SE", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
};

export const dateFormatShort = (dateString: string): string => {
  const date = new Date(dateString);
  return date.toLocaleDateString("sv-SE", {
    year: "2-digit",
    month: "short",
    day: "numeric",
  });
};
