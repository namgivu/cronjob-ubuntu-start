from src.main import run


class Test:

    def test(self):
        r = run()
        assert r.status_code==200
