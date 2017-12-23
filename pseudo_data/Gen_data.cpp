/*****************************************************************************/
/*                              Gen_data.cpp                                 */
/*****************************************************************************/
#include <cmath>
#include <random>
#include <fstream>
#include <iostream>
#define _USE_MATH_DEFINES
#include <math.h>
//=============================================================================
class Gen_data
{
private:
  double output;
  double outputs[10000][10000];
  
public:
  Gen_data();
  ~Gen_data(void);
  double get (int i, int j);
  double N_Random (int n, int dim, double data[][3]);
  double Sin_func (int n, int m, double data[][3]);
};
//=============================================================================
/*! Constructor */
Gen_data::Gen_data
(
) 
{
}
//=============================================================================
/*! Destructor */
Gen_data::~Gen_data(void)
{
}
//=============================================================================
/* 値を呼び出す */
double Gen_data::get
(
 int i, // index number
 int j
 )
{
  output = outputs[i][j];
}
//=============================================================================
/* ガウス分布の乱数発生させる */
double Gen_data::N_Random
(
 int n,   // 乱数発生回数
 int dim, // 入力データの行数
 double data[][3] // 入力データ
 )
{
  std::random_device seed_gen;
  std::mt19937_64 engine(seed_gen());

  for (std::size_t i = 0; i < dim; ++i) {
    for (int j = 0; j < 3; ++j) {
      for (int k = 0; k < n; ++k) {
        // 平均 0.5、標準偏差 0.16 で分布させる
        std::normal_distribution<> dist(0.5,0.16);
        // 正規分布で乱数を生成する
        double result = dist(engine);
        if (result <= 0) {
          result = 0;
        } else if (result >= 1) {
          result = 1;
        }
        outputs[i*3+k][j] = result * data[i][j];
      }
    }
  }
}
//=============================================================================
/* 時系列データを発生させる　*/
double Gen_data::Sin_func
(
 int n, // 時間ステップ
 int m, // 人数
 double data[][3] // 入力データ
 )
{
  for (int i = 0; i < n; ++i) {   // 時間ステップ
    for (int j = 0; j < m; ++j) { // 人数
      double result = data[j][0] * sin(2 * M_PI * i / n - data[j][1]) + data[j][2];
      if (result <= 0) {
        result = 0;
      } else if (result >= 1) {
        result = 1;
      }
      outputs[i][j] = result;
    }
  }
}
//=============================================================================
int main(void)
{
  int dim_p = 30;         // 人数
  int time_step = 48;    // 時間ステップ:30分間隔
  double sin_a = 0.5;    // sin_aの系数
  double sin_b = 2*M_PI; // sin_bの系数
  double sin_c = 0.5;    // sin_cの系数
  double para_i[time_step][3]; // [データ数][a/b/c]
  double data_i[time_step][dim_p]; // [タイムステップ][人数]
  
  std::ofstream fout1_file;
  std::ofstream fout2_para;
  std::ofstream fout3_data;
  fout1_file.open("file.dat");
  fout2_para.open("para.dat");
  fout3_data.open("data.dat");

  double input_data[1][3] = {sin_a, sin_b, sin_c};

  fout1_file << "Input data" << std::endl;
  fout1_file << "sin_a = " << sin_a << "\tsin_b = " << sin_b << "\tsin_c = " << sin_c << std::endl; 
  fout1_file << dim_p << " people" << std::endl << std::endl;
  
  // ガウス分布に従うsin関数のパラメータを発生させる
  Gen_data job_random;
  Gen_data *job= &job_random;

  job->N_Random(dim_p,1,input_data); // 人数分のsin関数のパラメータを発生させる
  
  for (int i = 0; i < dim_p; i++) { // 人数
    for (int j = 0; j < 3; j++) {   // [a/b/c]
      para_i[i][j] = job->get(i,j);
      fout2_para << para_i[i][j] << "\t";
    }
    fout2_para << std::endl;
  }

  Gen_data Sin_generation;
  Gen_data *sin_func= &Sin_generation;

  sin_func->Sin_func(time_step,dim_p,para_i);
  
  for (int i = 0; i < time_step; i++) { // 時間ステップ
    for (int j = 0; j < dim_p; j++) {   // 人数
      data_i[i][j] = sin_func->get(i,j);
      fout3_data << data_i[i][j] << "\t";
    }
    fout3_data << std::endl;
  }

  fout1_file.close();
  fout2_para.close();
  fout3_data.close();
}
//=============================================================================
