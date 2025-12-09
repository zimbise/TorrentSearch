package com.prajwalch.torrentsearch.providers

object ProviderRegistry {

    val allProviders: List<SearchProvider> by lazy {
        listOf(
            Acgrip(),
            BigFanGroup(),
            Bitru(),
            ExtraTorrentSt(),
            FiftyTwoBt(),
            FreeJavTorrent(),
            Idope(),
            IsoHunt2(),
            JackettAll(),
            KickassTorrentsTo(),
            KickassTorrentsWs(),
            Knaben(),
            MyPornClub(),
            NorTorrent(),
            OneJav(),
            OpenSharing(),
            PornoTorrent(),
            PornRips(),
            ProwlarrAll(),
            RinTorrent(),
            RuTrackerRu(),
            Sosulki(),
            SukebeinYaasi(),
            ThePirateBay(),
            TheRarbg(),
            TokyoTosho(),
            TorrentCore(),
            TorrentDownload(),
            TorrentGalaxyClone(),
            TorrentPirat(),
            TorrentQQ(),
            TorznabSearchProvider(
                TorznabSearchProviderConfig(
                    id = "torznab-generic",
                    name = "Torznab Generic",
                    url = "http://192.168.1.175:9117/api/v2.0/indexers/all/results/torznab/"
                )
            ),
            Traht(),
            U3C3(),
            UIndex(),
            X1337x(),
            XxxClub(),
            XxxTor(),
            ZeroMagnet(),
            ZkTorrent(),
        )
    }
}
