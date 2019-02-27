#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <iostream>
#include <stdlib.h>
#include <stdio.h>

using namespace cv;

/// Global variables

Mat src, src_gray;
Mat dst, detected_edges;

int edgeThresh = 1;
int lowThreshold;
int const max_lowThreshold = 100;
int ratio = 3;
int kernel_size = 3;
char* window_name = "Edge Map";

/**
 * @function CannyThreshold
 * @brief Trackbar callback - Canny thresholds input with a ratio 1:3
 */
void myKernel(Mat source, Mat edge) {
  /* source image and edge image have same shape */
  // int row, col = cv.Getsize(source);
  int row = source.size().height;
  int col = source.size().width;
  std::cout << "row: " << row << " col: " << col << std::endl;
  const int kernelSize = 3;
  const int edgeWidth = (kernelSize - 1) / 2;

  for (int i = edgeWidth; i < row - edgeWidth; i++) {
    for (int j = edgeWidth; j < col - edgeWidth; j ++) {
      int dif = 8 * source.at<uchar>(i, j) - 
            source.at<uchar>(i - 1, j - 1) - source.at<uchar>(i - 1, j) - source.at<uchar>(i - 1, j + 1) -
            source.at<uchar>(i, j - 1) - source.at<uchar>(i, j + 1) - 
            source.at<uchar>(i + 1, j - 1) - source.at<uchar>(i + 1, j) - source.at<uchar>(i + 1, j + 1);
            // std::cout << dif << std::endl;
      if (abs(dif) > 35) {
        edge.at<uchar>(i, j) = 255;
      }
      else {
        edge.at<uchar>(i, j) = 0;
      }
    }
  }
}

void CannyThreshold(int, void*)
{
  /// Reduce noise with a kernel 3x3
  blur( src_gray, detected_edges, Size(3,3) );

  /// Canny detector
  // Canny( detected_edges, detected_edges, lowThreshold, lowThreshold*ratio, kernel_size );
  myKernel(src_gray, detected_edges);
  /// Using Canny's output as a mask, we display our result
  dst = Scalar::all(0);

  src.copyTo( dst, detected_edges);
  imshow( window_name, dst );
  imwrite( "./images/result.jpg", dst );
 }


/** @function main */
int main( int argc, char** argv )
{
  /// Load an image
  src = imread( "./images/sample.jpg" );
  imshow ("original img", src);
  if( !src.data )
  { return -1; }

  /// Create a matrix of the same type and size as src (for dst)
  dst.create( src.size(), src.type() );

  /// Convert the image to grayscale
  cvtColor( src, src_gray, CV_BGR2GRAY );

  /// Create a window
  namedWindow( window_name, CV_WINDOW_AUTOSIZE );

  /// Create a Trackbar for user to enter threshold
  // createTrackbar( "Min Threshold:", window_name, &lowThreshold, max_lowThreshold, CannyThreshold );

  /// Show the image
  CannyThreshold(0, 0);

  /// Wait until user exit program by pressing a key
  waitKey(0);

  return 0;
  }