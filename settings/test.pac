function FindProxyForURL(url,host) {
	var proxy = "PROXY 172.29.4.3:8080";

	function isBitway(host) {
		return shExpMatch(host, "172.27.*")
			|| shExpMatch(host, "172.28.*")
			|| shExpMatch(host, "10.*")
			|| shExpMatch(host, "*.intra.bitway.co.jp")
			|| shExpMatch(host, "pubridge-redmine.bitway.ne.jp");
	}

	if (isBitway(host)) {
		return proxy;
	}
	/* To Internet */
	return "DIRECT";
}
