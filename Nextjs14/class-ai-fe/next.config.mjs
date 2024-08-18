/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode:false,
    async redirects() {
        return [
          {
            source: '/',
            destination: '/class',
            permanent: true,
          },
        ]
    },
};

export default nextConfig;
