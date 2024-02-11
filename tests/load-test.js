import http from "k6/http";
import { check, sleep } from "k6";

export const options = {
  thresholds: {
    // http errors should be less than 1%
    http_req_failed: ['rate<0.01'],
    // Assert that 90% of requests finish within 200ms and 95% of requests finish within 300ms.
    http_req_duration: ["p(90)<200", "p(95)<300"],
  },
  stages: [
    { duration: "30s", target: 50 }, 
    { duration: "1m", target: 50 }, 
    { duration: "30s", target: 0 },
  ],
};


export default function () {
    const hostnames = [
      "http://foo.localhost",
      "http://bar.localhost",
    ]
    for (const host of hostnames) {
      const res = http.get(host);
      check(res, {
        "status was 200": (r) => r.status == 200
      });
      sleep(1);
    }
}

export function handleSummary(data) {
    console.log('Finished executing load tests');

    console.log("Check values:", JSON.stringify(data.metrics))

    const latency = JSON.stringify(data.metrics.http_req_duration.values);
    const latency_message = `The latency values are ${latency}\n`;

    // https://github.com/grafana/k6/issues/2386 - swap http_req_failed passes and fails to fix k6 bug
    let errors = data.metrics.http_req_failed.values
    let temp = errors.passes;
    errors.passes = errors.fails;
    errors.fails = temp;
    errors = JSON.stringify(errors);
    const errors_message = `The error values are ${errors}\n`;

    const traffic = JSON.stringify(data.metrics.http_reqs.values);
    const traffic_message = `The traffic values are ${traffic}\n`;
  
    return {
      stdout: latency_message.concat(errors_message, traffic_message),
    };
  }