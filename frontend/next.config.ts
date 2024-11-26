import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    domains: ["localhost"], // For NextJS image optimization we have to write domain here.
  },
};

export default nextConfig;
