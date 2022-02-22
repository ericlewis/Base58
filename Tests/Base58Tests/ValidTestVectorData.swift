let validTestVectorData =
    """
    [
        {
            "string": "",
            "encodedString": ""
        },
        {
            "string": " ",
            "encodedString": "Z"
        },
        {
            "string": "-",
            "encodedString": "n"
        },
        {
            "string": "0",
            "encodedString": "q"
        },
        {
            "string": "1",
            "encodedString": "r"
        },
        {
            "string": "-1",
            "encodedString": "4SU"
        },
        {
            "string": "11",
            "encodedString": "4k8"
        },
        {
            "string": "abc",
            "encodedString": "ZiCa"
        },
        {
            "string": "1234598760",
            "encodedString": "3mJr7AoUXx2Wqd"
        },
        {
            "string": "abcdefghijklmnopqrstuvwxyz",
            "encodedString": "3yxU3u1igY8WkgtjK92fbJQCd4BZiiT1v25f"
        },
        {
            "string": "00000000000000000000000000000000000000000000000000000000000000",
            "encodedString": "3sN2THZeE9Eh9eYrwkvZqNstbHGvrxSAM7gXUXvyFQP8XvQLUqNCS27icwUeDT7ckHm4FUHM2mTVh1vbLmk7y"
        }
    ]
    """
    .data(using: .utf8)!
