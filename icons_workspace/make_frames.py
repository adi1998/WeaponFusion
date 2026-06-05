from PIL import Image, ImageDraw
import os

INPUT = "filled.png"
BASE = "empty.png"
OUTPUT_DIR = "frames"

FRAME_COUNT = 60

os.makedirs(OUTPUT_DIR, exist_ok=True)

ring = Image.open(INPUT).convert("RGBA")
w, h = ring.size

for i in range(FRAME_COUNT + 1):
    progress = i / FRAME_COUNT

    mask = Image.new("L", (w, h), 0)
    draw = ImageDraw.Draw(mask)

    start_angle = -90
    end_angle = start_angle + progress * 360

    draw.pieslice(
        [0, 0, w - 1, h - 1],
        start=start_angle,
        end=end_angle,
        fill=255
    )

    # frame = Image.open(BASE).convert("RGBA")
    frame = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    frame.paste(ring, mask=mask)

    frame.save(
        os.path.join(
            OUTPUT_DIR,
            f"circle_hold{i:04d}.png"
        )
    )

print(f"Generated {FRAME_COUNT + 1} frames")