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

pub fn gen_random_vec(n : Int) -> @vec.Vec[Double] {
  let a = @vec.Vec::with_capacity(n)
  for i = 0; i < n; i = i + 1 {
    a.push(random())
  }
  a
}

pub fn gen_same(n : Int) -> Array[Double] {
  let a = Array::make(n, 0.0)
  a
}

pub fn gen_reversed(n : Int) -> Array[Double] {
  let a = Array::make(n, 0.0)
  for i = 0; i < n; i = i + 1 {
    a[i] = (n - i).to_double()
  }
  a
}

pub fn sort(a : Array[Double]) -> Unit {
  a.sort()
}

pub fn sort_vec(a : @vec.Vec[Double]) -> Unit {
  a.sort()
}
