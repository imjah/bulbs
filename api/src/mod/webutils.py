import json

BR = "\r\n"

async def get_body_json(request):
    content_length = int(request.headers.get('Content-Length', 0))

    if content_length:
        return json.loads(await request.read(content_length) or {})

async def write_response(request, code=200, message="OK"):
    await request.write(f"HTTP/1.1 {code} {message}{BR*2}")

async def write_response_json(request, body, code=200, message="OK"):
    await request.write(f"HTTP/1.1 {code} {message}{BR}")
    await request.write(f"Content-Type: application/json{BR*2}")
    await request.write(f"{json.dumps(body)}{BR}")

