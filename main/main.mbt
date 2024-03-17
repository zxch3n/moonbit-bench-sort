fn main {

}

fn random() -> Double = "math" "random"

pub fn gen_random(n : Int) -> Array[Double] {
  let a = Array::make(n, 0.0)
  for i = 0; i < n; i = i + 1 {
    a[i] = random()
  }
  a
}

pub fn gen_sorted(n : Int) -> Array[Double] {
  let a = Array::make(n, 0.0)
  for i = 0; i < n; i = i + 1 {
    a[i] = i.to_double()
  }
  a
}

pub fn gen_reversed(n : Int) -> Array[Double] {
  let a = Array::make(n, 0.0)
  for i = 0; i < n; i = i + 1 {
    a[i] = (n - i).to_double()
  }
  a
}

pub fn sort(a : Array[Double]) {
  a.sort()
}
