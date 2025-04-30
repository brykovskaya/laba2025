from flask import Flask, request, jsonify
from feast import FeatureStore

app = Flask(__name__)
store = FeatureStore(repo_path=".")


@app.route('/get_features', methods=['POST'])
def get_features():
    passenger_id = request.json['PassengerId']
    features = store.get_online_features(
        features=[
            "titanic_features:Age",
            "titanic_features:Sex",
            "titanic_features:Pclass",
            "titanic_features:Fare",
            "titanic_features:Embarked",
            "titanic_features:FamilySize",
            "titanic_features:IsAlone",
        ],
        entity_rows=[{"PassengerId": passenger_id}]
    ).to_dict()
    return jsonify(features)


if __name__ == '__main__':
    app.run(debug=True)
