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
    { duration: "50s", target: 200 }, 
    { duration: "5m", target: 200 }, 
    { duration: "50s", target: 0 },
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

    const errors = JSON.stringify(data.metrics.http_req_failed.values);
    const errors_message = `The error values are ${errors}\n`;

    const traffic = JSON.stringify(data.metrics.http_reqs.values);
    const traffic_message = `The traffic values are ${traffic}\n`;
  
    return {
      stdout: latency_message.concat(errors_message, traffic_message),
    };
  }