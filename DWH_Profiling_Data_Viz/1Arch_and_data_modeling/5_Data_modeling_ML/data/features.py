from datetime import timedelta
from feast import FeatureView, Field, FileSource, Entity
from feast.types import Float32, Int32
from feast.value_type import ValueType

passenger_entity = Entity(
    name='PassengerId',
    join_keys=['PassengerId'],
    description='Уникальный идентификатор пассажира',
    value_type=ValueType.INT32,
)

titanic_source = FileSource(
    path='data/titanic_preprocessed.parquet',
    event_timestamp_column='timestamp',
    created_timestamp_column='created',
    timestamp_field='timestamp'
)

titanic_features = FeatureView(
    name='titanic_features',
    entities=[passenger_entity],
    ttl=timedelta(days=365),
    schema=[
        Field(name='Age', dtype=Float32),
        Field(name='Sex', dtype=Int32),
        Field(name='Pclass', dtype=Int32),
        Field(name='Fare', dtype=Float32),
        Field(name='Embarked', dtype=Int32),
        Field(name='FamilySize', dtype=Int32),
        Field(name='IsAlone', dtype=Int32),
    ],
    online=True,
    source=titanic_source,
    tags={},
)
