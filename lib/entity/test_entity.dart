class TestEntity {
	int doing;
	TestTest test;
	int finish;

	TestEntity({this.doing, this.test, this.finish});

	TestEntity.fromJson(Map<String, dynamic> json) {
		doing = json['doing'];
		test = json['test'] != null ? new TestTest.fromJson(json['test']) : null;
		finish = json['finish'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['doing'] = this.doing;
		if (this.test != null) {
      data['test'] = this.test.toJson();
    }
		data['finish'] = this.finish;
		return data;
	}
}

class TestTest {
	int doing;
	int finish;

	TestTest({this.doing, this.finish});

	TestTest.fromJson(Map<String, dynamic> json) {
		doing = json['doing'];
		finish = json['finish'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['doing'] = this.doing;
		data['finish'] = this.finish;
		return data;
	}
}
