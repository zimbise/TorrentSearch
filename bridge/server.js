const express = require('express');
const fetch = require('node-fetch');
const app = express();
app.use(express.json());

app.get('/providers', async (_req, res) => {
  try {
    const jackett = await fetch(`${process.env.JACKETTURL}/api/v2.0/indexers/all/results/torznab?apikey=${process.env.JACKETTAPIKEY}`).then(r => r.json());
    const prowlarr = await fetch(`${process.env.PROWLARRURL}/api/v1/indexer`).then(r => r.json());

    const providers = [];

    if (jackett?.indexers) {
      for (const j of jackett.indexers) {
        providers.push({
          id: `jackett-${j.id}`,
          name: j.name,
          url: j.torznabUrl,
          apiKey: process.env.JACKETTAPIKEY,
          category: "All",
          unsafeReason: null
        });
      }
    }

    for (const p of prowlarr) {
      providers.push({
        id: `prowlarr-${p.id}`,
        name: p.name,
        url: `${process.env.PROWLARRURL}/api/v1/indexer/${p.id}/results/torznab`,
        apiKey: process.env.PROWLARRAPIKEY,
        category: "All",
        unsafeReason: null
      });
    }

    res.json(providers);
  } catch (e) {
    console.error(e);
    res.json([]);
  }
});

app.listen(3000, () => console.log('Bridge running on 3000'));
