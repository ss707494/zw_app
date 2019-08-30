class UserCoinEntity {
	int cardNumber;
	int nextMouthIcons;
	int currentMouthIcons;

	UserCoinEntity({this.cardNumber, this.nextMouthIcons, this.currentMouthIcons});

	UserCoinEntity.fromJson(Map<String, dynamic> json) {
		cardNumber = json['card_number'];
		nextMouthIcons = json['next_mouth_icons'];
		currentMouthIcons = json['current_mouth_icons'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['card_number'] = this.cardNumber;
		data['next_mouth_icons'] = this.nextMouthIcons;
		data['current_mouth_icons'] = this.currentMouthIcons;
		return data;
	}
}
