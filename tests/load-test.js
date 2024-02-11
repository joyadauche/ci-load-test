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
    { duration: "30s", target: 30 }, 
    { duration: "1m", target: 30 }, 
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

    const latency = JSON.stringify(data.metrics.http_req_duration.values);
    const latency_message = `The latency values are ${latency}\n`;

    const errors = JSON.stringify(data.metrics.http_req_failed.values);
    const errors_message = `The error values are ${errors}\n`;

    const traffic = JSON.stringify(data.metrics.http_req.values);
    const traffic_message = `The error values are ${traffic}\n`;

    const message = latency_message + errors_message + traffic_message
  
    return {
      stdout: message,
    };
  }