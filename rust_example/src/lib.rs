use futures::stream::Stream;
use membrane::async_dart;
use once_cell::sync::Lazy;
use tokio::runtime::{Builder, Runtime};

pub(crate) static RUNTIME: Lazy<Runtime> = Lazy::new(|| {
    Builder::new_multi_thread()
        .worker_threads(2)
        .thread_name("example")
        .enable_time()
        .build()
        .unwrap()
});

#[async_dart(namespace = "time")]
pub fn current_time() -> impl Stream<Item = Result<i64, String>> {
    use std::time::{SystemTime, UNIX_EPOCH};
    use tokio::time::{sleep, Duration};

    let mut prev = SystemTime::now().duration_since(UNIX_EPOCH).unwrap();

    async_stream::stream! {
      loop {
        sleep(Duration::from_millis(10)).await;
        let now = SystemTime::now().duration_since(UNIX_EPOCH).unwrap();
        if now != prev {
            prev = now;
            yield Ok(now.as_secs() as i64);
        }
      }
    }
}

pub fn load() {}
