import { registerPlugin } from '@capacitor/core';

import type { ApplePayPlugin } from './definitions';

const ApplePay = registerPlugin<ApplePayPlugin>('ApplePay', {
  web: () => import('./web').then(m => new m.ApplePayWeb()),
});

export * from './definitions';
export { ApplePay };
