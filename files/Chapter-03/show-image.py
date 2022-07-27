import cv2

img = cv2.imread('test-image.jpg')

cv2.imshow('Sample Image',img)
cv2.waitKey(0)
cv2.destroyAllWindows()