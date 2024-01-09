from pdf2image import convert_from_path
from PIL import Image

images = convert_from_path('cv.pdf')
images[0].save('cv.png', 'PNG')