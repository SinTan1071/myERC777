module.exports = {
  networks: {
    development: {
      protocol: 'http',
      host: 'localhost',
      port: 1723,
      gas: 5000000,
      gasPrice: 5e9,
      networkId: '*',
    },
  },
};
