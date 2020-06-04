#!/usr/bin/python3
import json
print(
    json.dumps(
        dict(
            bootstrap=dict(
                hosts=[
                    'localhost'
                ],
                vars=dict(
                    ansible_connection='local',
                    ansible_python_interpreter='/usr/bin/python3'
                )
            )
        )
    )
)
